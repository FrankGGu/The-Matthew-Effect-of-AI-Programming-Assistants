func majorityElement(nums []int) []int {
    if len(nums) == 0 {
        return []int{}
    }

    // Initialize two candidates and their counts
    cand1, cand2 := 0, 0
    count1, count2 := 0, 0

    // First pass to find potential candidates
    for _, num := range nums {
        if num == cand1 {
            count1++
        } else if num == cand2 {
            count2++
        } else if count1 == 0 {
            cand1 = num
            count1 = 1
        } else if count2 == 0 {
            cand2 = num
            count2 = 1
        } else {
            count1--
            count2--
        }
    }

    // Second pass to verify the counts of the potential candidates
    count1 = 0
    count2 = 0
    for _, num := range nums {
        if num == cand1 {
            count1++
        } else if num == cand2 { // Use else if to avoid double counting if cand1 and cand2 somehow became the same
            count2++
        }
    }

    var result []int
    n := len(nums)
    if count1 > n/3 {
        result = append(result, cand1)
    }
    if count2 > n/3 {
        // Ensure cand2 is not the same as cand1 if cand1 was already added
        // This check is technically redundant because the Boyer-Moore variant ensures cand1 and cand2
        // will hold distinct values after the first pass, unless one of them was never assigned
        // or one of them is the default zero value and that value is also a majority element.
        // However, the `else if` in the verification loop already handles distinct counting correctly.
        if len(result) == 0 || result[0] != cand2 {
            result = append(result, cand2)
        }
    }

    return result
}