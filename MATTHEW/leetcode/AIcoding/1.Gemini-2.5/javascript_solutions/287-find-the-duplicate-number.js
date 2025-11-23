var findDuplicate = function(nums) {
    let slow = nums[0];
    let fast = nums[nums[0]];

    while (slow !== fast) {
        slow = nums[slow];
        fast = nums[nums[fast]];
    }

    let finder = 0;
    while (finder !== slow) {
        finder = nums[finder];
        slow = nums[slow];
    }

    return finder;
};