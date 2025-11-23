var minimumSize = function(nums, maxOperations) {
    let left = 1;
    let right = Math.max(...nums);
    let answer = right;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let operations = 0;

        for (const num of nums) {
            operations += Math.floor((num - 1) / mid);
        }

        if (operations <= maxOperations) {
            answer = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return answer;
};