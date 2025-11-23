function removeAnagrams(nums) {
    const result = [];
    let prev = '';

    for (const num of nums) {
        const sorted = num.split('').sort().join('');
        if (sorted !== prev) {
            result.push(num);
            prev = sorted;
        }
    }

    return result;
}