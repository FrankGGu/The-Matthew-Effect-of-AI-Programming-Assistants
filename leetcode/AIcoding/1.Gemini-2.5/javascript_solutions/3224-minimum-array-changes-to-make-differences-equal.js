var minimumArrayChanges = function(nums, k) {
    const n = nums.length;

    const freq = new Array(k).fill(0);
    for (let i = 0; i < n; i++) {
        freq[nums[i] % k]++;
    }

    let minOperations = n; 

    for (let R = 0; R < k; R++) {
        let currentOperations = n - freq[R];

        let costP0 = 0; 
        let costP1 = 0; 

        for (let i = 0; i < n; i++) {
            if (nums[i] % k === R) {
                const m_i_val = (nums[i] - R) / k;

                if ((m_i_val % 2) !== (i % 2)) {
                    costP0++;
                }

                if ((m_i_val % 2) === (i % 2)) {
                    costP1++;
                }
            }
        }

        minOperations = Math.min(minOperations, currentOperations + costP0);
        minOperations = Math.min(minOperations, currentOperations + costP1);
    }

    return minOperations;
};