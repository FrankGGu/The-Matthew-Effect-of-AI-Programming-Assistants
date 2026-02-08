bool containsDuplicate(int* nums, int numsSize) {
    HashSet<int> set;
    for (int i = 0; i < numsSize; i++) {
        if (set.find(nums[i]) != set.end()) {
            return true;
        }
        set.insert(nums[i]);
    }
    return false;
}