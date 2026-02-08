var separateDigits = function(nums) {
    const ans = [];
    for (const num of nums) {
        const s = String(num);
        for (const char of s) {
            ans.push(Number(char));
        }
    }
    return ans;
};