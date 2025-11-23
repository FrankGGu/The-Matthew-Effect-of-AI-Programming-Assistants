func sumOfUnique(nums []int) int {
    // Since nums[i] is between 1 and 100, an array can be used for frequency counting.
    // freq[i] will store the count of number i.
    // We need indices up to 100, so an array of size 101 is appropriate (0-indexed).
    freq := make([]int, 101) 

    // Populate the frequency array
    for _, num := range nums {
        freq[num]++
    }

    sum := 0
    // Iterate from 1 to 100 (inclusive) as these are the possible values for nums[i]
    for i := 1; i <= 100; i++ {
        if freq[i] == 1 { // If the number appears exactly once
            sum += i       // Add it to the total sum
        }
    }

    return sum
}