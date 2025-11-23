function generateAllPalindromes() {
    const palindromes = new Set();
    const MAX_NUM = 1000000000; // Max value for nums[i]

    // Single digit palindromes
    for (let i = 1; i <= 9; i++) {
        palindromes.add(i);
    }

    // Generate palindromes from 'half' numbers
    // For numbers up to 10^9, the half length can be up to 5.
    // E.g., for 9-digit palindrome 123454321, its half is 12345 (length 5).
    // For 10-digit palindrome 1000000001, its half is 10000 (length 5).
    // We only need to consider palindromes <= MAX_NUM.
    for (let len_half = 1; len_half <= 5; len_half++) {
        const start_num = Math.pow(10, len_half - 1);
        const end_num = Math.pow(10, len_half) - 1;

        for (let i = start_num; i <= end_num; i++) {
            const s_i = String(i);

            // Odd length palindrome (e.g., 123 -> 12321)
            // s_i = "123", s_i.substring(0, s_i.length - 1) = "12", reverse = "21" => "12321"
            const p_odd_str = s_i + s_i.substring(0, s_i.length - 1).split('').reverse().join('');
            const p_odd = Number(p_odd_str);
            if (p_odd <= MAX_NUM) {
                palindromes.add(p_odd);
            }

            // Even length palindrome (e.g., 12 -> 1221)
            // s_i = "12", reverse = "21" => "1221"
            const p_even_str = s_i + s_i.split('').reverse().join('');
            const p_even = Number(p_even_str);
            if (p_even <= MAX_NUM) {
                palindromes.add(p_even);
            }
        }
    }

    return Array.from(palindromes).sort((a, b) => a - b);
}

function bisectLeft(arr, x) {
    let low = 0, high = arr.length;
    while (low < high) {
        let mid = Math.floor((low + high) / 2);
        if (arr[mid] < x) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    return low;
}

function calculateCost(nums, p) {
    let cost = 0;
    for (const num of nums) {
        cost += Math.abs(num - p);
    }
    return cost;
}

var minCost = function(nums) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    const median_val = nums[Math.floor((n - 1) / 2)];

    const all_palindromes = generateAllPalindromes();

    const candidates = new Set();

    const idx = bisectLeft(all_palindromes, median_val);

    // Add a window of palindromes around the median_val's insertion point
    // A constant window size (e.g., +/- 10) is sufficient because the cost function
    // sum(|num_i - p|) is convex, and its minimum will be close to the median.
    const K = 10; 
    for (let i = Math.max(0, idx - K); i <= Math.min(all_palindromes.length - 1, idx + K); i++) {
        candidates.add(all_palindromes[i]);
    }

    let min_cost = Infinity;

    for (const p of candidates) {
        min_cost = Math.min(min_cost, calculateCost(nums, p));
    }

    return min_cost;
};