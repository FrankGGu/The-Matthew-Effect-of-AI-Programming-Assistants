function nextBeautifulNumber(n) {
    function isBalanced(num) {
        const count = new Array(7).fill(0);
        while (num > 0) {
            const digit = num % 10;
            if (digit === 0 || digit > 6) return false;
            count[digit]++;
            num = Math.floor(num / 10);
        }
        for (let i = 1; i <= 6; i++) {
            if (count[i] === i) continue;
            else return false;
        }
        return true;
    }

    function nextPermutation(arr) {
        let i = arr.length - 2;
        while (i >= 0 && arr[i] >= arr[i + 1]) i--;
        if (i < 0) return false;
        let j = arr.length - 1;
        while (arr[j] <= arr[i]) j--;
        [arr[i], arr[j]] = [arr[j], arr[i]];
        let left = i + 1, right = arr.length - 1;
        while (left < right) {
            [arr[left], arr[right]] = [arr[right], arr[left]];
            left++;
            right--;
        }
        return true;
    }

    function generateNumbers() {
        const result = [];
        const digits = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6];
        const used = new Array(digits.length).fill(false);
        const current = [];

        function backtrack(start) {
            if (current.length === 0) {
                for (let i = 0; i < digits.length; i++) {
                    if (!used[i]) {
                        used[i] = true;
                        current.push(digits[i]);
                        backtrack(i + 1);
                        current.pop();
                        used[i] = false;
                    }
                }
                return;
            }
            if (current.length === digits.length) {
                let num = parseInt(current.join(''), 10);
                if (isBalanced(num)) result.push(num);
                return;
            }
            for (let i = 0; i < digits.length; i++) {
                if (!used[i]) {
                    used[i] = true;
                    current.push(digits[i]);
                    backtrack(i + 1);
                    current.pop();
                    used[i] = false;
                }
            }
        }

        backtrack(0);
        return result;
    }

    const candidates = generateNumbers();
    candidates.sort((a, b) => a - b);

    for (const candidate of candidates) {
        if (candidate > n) return candidate;
    }

    return -1;
}