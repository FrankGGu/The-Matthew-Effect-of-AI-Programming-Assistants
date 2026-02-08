import "strings"

func smallestSubsequence(s string, k int, letter byte, repetition int) string {
    n := len(s)
    ans := []byte{}
    letterCountInAns := 0

    // Precompute suffixLetterCount: count of 'letter' in s[j:]
    // suffixLetterCount[i] stores the count of 'letter' in s[i...n-1]
    suffixLetterCount := make([]int, n+1)
    for i := n - 1; i >= 0; i-- {
        suffixLetterCount[i] = suffixLetterCount[i+1]
        if s[i] == letter {
            suffixLetterCount[i]++
        }
    }

    for i := 0; i < n; i++ {
        char := s[i]

        // remainingLettersInSFromNext is the count of 'letter' in s[i+1...n-1]
        remainingLettersInSFromNext := suffixLetterCount[i+1]

        // Pop condition:
        // While stack is not empty, current char is smaller than top of stack,
        // AND we can still form a k-length subsequence if we pop,
        // AND if top of stack is 'letter', we can afford to pop it (i.e., we can still meet 'repetition' count).
        for len(ans) > 0 && char < ans[len(ans)-1] {
            // Condition 1: Can we still form a k-length subsequence if we pop?
            // If we pop ans[len(ans)-1], the new length is len(ans)-1.
            // We need to pick k - (len(ans)-1) more characters from s[i...n-1].
            // The number of available characters from s[i...n-1] is (n - i).
            // So, (len(ans) - 1) + (n - i) must be >= k.
            if len(ans)-1+(n-i) < k {
                break
            }

            // Condition 2: If ans[len(ans)-1] is 'letter', check if we can afford to pop it.
            if ans[len(ans)-1] == letter {
                // If we pop this 'letter', the count becomes letterCountInAns - 1.
                // We need to ensure that (letterCountInAns - 1) + remainingLettersInSFromNext >= repetition.
                if (letterCountInAns - 1) + remainingLettersInSFromNext < repetition {
                    break
                }
                letterCountInAns--
            }
            ans = ans[:len(ans)-1]
        }

        // Push condition:
        // Only push if ans is not yet k length.
        // And if char is not 'letter', ensure we can still meet 'repetition' count later.
        if len(ans) < k {
            if char == letter {
                ans = append(ans, char)
                letterCountInAns++
            } else { // char is not 'letter'
                // Can we afford to push a non-'letter'?
                // We need to ensure that after pushing this non-'letter', we can still get 'repetition' letters.
                // The current letter count in ans is `letterCountInAns`.
                // The letters available from remaining string `s[i+1:]` is `remainingLettersInSFromNext`.
                if letterCountInAns+remainingLettersInSFromNext >= repetition {
                    ans = append(ans, char)
                }
            }
        }
    }

    return string(ans)
}