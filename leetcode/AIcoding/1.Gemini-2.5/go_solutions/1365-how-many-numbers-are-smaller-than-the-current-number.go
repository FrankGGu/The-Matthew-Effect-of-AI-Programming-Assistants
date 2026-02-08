func smallerNumbersThanCurrent(nums []int) []int {
    // Since nums[i] are between 0 and 100, we can use a counting sort approach.
    // Create a frequency array to store counts of each number.
    // The size is 101 to accommodate numbers from 0 to 10