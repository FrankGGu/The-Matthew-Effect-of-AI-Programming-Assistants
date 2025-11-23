func countSubarrays(nums []int, k int) int {
    n := len(nums)
    kIdx := -1
    for i := 0; i < n; i++ {
        if nums[i] == k {
            kIdx = i
            break
        }
    }

    ans := 0

    // freq stores counts of balances for subarrays ending at kIdx-1
    // (i.e., nums[i...kIdx-1])
    freq := make(map[int]int)
    currentBalance := 0

    // Add 1 for the empty prefix to the left of kIdx (balance 0)
    freq[0] = 1 

    // Calculate balances for the left part (nums[0...kIdx-1])
    for i := kIdx - 1; i >= 0; i-- {
        if nums[i] > k {
            currentBalance++
        } else { // nums[i] < k
            currentBalance--
        }
        freq[currentBalance]++
    }

    // Calculate balances for the right part (nums[kIdx...n-1])
    // And combine with left part balances
    currentBalance = 0 // This will represent balance(nums[kIdx...j])
    for j := kIdx; j < n; j++ {
        if nums[j] > k {
            currentBalance++
        } else if nums[j] < k {
            currentBalance--
        }
        // If nums[j] == k, currentBalance remains unchanged (0 contribution)

        // We are looking for subarrays nums[i...j] such that i <= kIdx <= j.
        // The total balance for nums[i...j] is balance(nums[i...kIdx-1]) + balance(nums[kIdx...j]).
        // Let balL = balance(nums[i...kIdx-1]) and balR = balance(nums[kIdx...j]).
        // We need balL + balR == 0 or balL + balR == 1.
        // So, balL == -balR or balL == 1 - balR.
        // Here, balR is our currentBalance.
        ans += freq[-currentBalance]
        ans += freq[1-currentBalance]
    }

    return ans
}