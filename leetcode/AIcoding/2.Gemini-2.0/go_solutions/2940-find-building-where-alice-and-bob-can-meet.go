func findMeetingCells(heights []int) []int {
    n := len(heights)
    alice := 0
    bob := n - 1
    aliceVisited := make([]bool, n)
    bobVisited := make([]bool, n)

    for !aliceVisited[alice] {
        aliceVisited[alice] = true
        alice = (alice + heights[alice]) % n
    }

    for !bobVisited[bob] {
        bobVisited[bob] = true
        bob = (bob - heights[bob]%n + n) % n
    }

    result := []int{}
    for i := 0; i < n; i++ {
        alice = 0
        bob = n - 1
        aliceLoop := false
        bobLoop := false
        aliceLoopStart := -1
        bobLoopStart := -1
        alicePath := []int{}
        bobPath := []int{}
        aliceVisitedLocal := make([]bool, n)
        bobVisitedLocal := make([]bool, n)

        for !aliceLoop && !aliceVisitedLocal[alice] {
            alicePath = append(alicePath, alice)
            aliceVisitedLocal[alice] = true
            if alice == i {
                break
            }
            alice = (alice + heights[alice]) % n
        }
        if alice != i {
            continue
        }

        for !bobLoop && !bobVisitedLocal[bob] {
            bobPath = append(bobPath, bob)
            bobVisitedLocal[bob] = true
            if bob == i {
                break
            }
            bob = (bob - heights[bob]%n + n) % n
        }
        if bob != i {
            continue
        }

        result = append(result, i)
    }

    return result
}