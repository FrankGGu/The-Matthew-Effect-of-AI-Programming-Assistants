var maximumSumQueries = function(nums1, nums2, queries) {
    const combined = nums1.map((num, index) => [num, nums2[index]]);
    combined.sort((a, b) => b[0] - a[0] || b[1] - a[1]);

    const sortedNums2 = [];
    const prefixMax = [];

    for (const [num1, num2] of combined) {
        while (sortedNums2.length > 0 && sortedNums2[sortedNums2.length - 1] <= num2) {
            sortedNums2.pop();
            prefixMax.pop();
        }
        sortedNums2.push(num2);
        prefixMax.push(Math.max((prefixMax.length > 0 ? prefixMax[prefixMax.length - 1] : 0), num1 + num2));
    }

    const answer = [];
    for (const [x, y] of queries) {
        let left = 0;
        let right = sortedNums2.length - 1;
        let res = -1;

        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (sortedNums2[mid] >= y) {
                res = prefixMax[mid];
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        answer.push(res);
    }
    return answer;
};