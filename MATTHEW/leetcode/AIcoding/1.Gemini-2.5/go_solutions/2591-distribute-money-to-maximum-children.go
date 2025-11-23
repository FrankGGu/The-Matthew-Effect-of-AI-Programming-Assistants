func distributeMoney(money int, children int) int {
    // If money is less than children, it's impossible to give each child at least $1.
    // Therefore, no child can receive $8.
    if money < children {
        return 0
    }

    // Calculate the maximum possible number of children that could potentially receive $8.
    // This is limited by the total number of children and the total money available (money / 8).
    maxPossibleEightReceivers := children
    if money/8 < maxPossibleEightReceivers {
        maxPossibleEightReceivers = money / 8
    }

    // Iterate 'k' (the number of children who receive exactly $8) downwards
    // from the maximum possible value.
    for k := maxPossibleEightReceivers; k >= 0; k-- {
        remainingMoney := money - k*8
        remainingChildren := children - k

        // Condition 1: Ensure there's enough money remaining for the other 'remainingChildren'
        // to each receive at least $1.
        // If remainingMoney is negative, it means k*8 > money, so this 'k' is too high.
        // If remainingMoney is positive but less than remainingChildren, it's also too high.
        if remainingMoney < remainingChildren {
            continue // This 'k' is not possible, try a smaller 'k'.
        }

        // Condition 2: Ensure no child among the 'remainingChildren' receives exactly $4.
        // This problematic scenario only occurs if there's exactly one remaining child
        // and exactly $4 remaining money. In this case, that child would be forced to take $4.
        if remainingChildren == 1 && remainingMoney == 4 {
            continue // This 'k' leads to an invalid distribution.
        }

        // If both conditions are met, this 'k' is a valid number of children receiving $8.
        // Since we are iterating 'k' downwards, this is the maximum possible such 'k'.
        return k
    }

    // If the loop completes without returning, it means no valid 'k' (from maxPossibleEightReceivers down to 0)
    // was found. This can happen in specific edge cases like money=4, children=1, where even k=0 is invalid.
    return 0
}