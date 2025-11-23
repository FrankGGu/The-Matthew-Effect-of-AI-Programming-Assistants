class Solution {
    public long minimumCost(String s) {
        int n = s.length();
        long totalCost = 0;

        // Iterate through the string and identify "flip" points.
        // A flip point occurs between s[i] and s[i+1] if s[i] != s[i+1].
        // To resolve this flip, we have two options:
        // 1. Change s[0...i] to match s[i+1]'s value.
        //    This means we need to change s[i] (and potentially s[i-1], s[i-2]...s[0] for free).
        //    The cost incurred for this operation is (i+1), which is the cost to change s[i].
        // 2. Change s[i+1...n-1] to match s[i]'s value.
        //    This means we need to change s[i+1] (and potentially s[i+2], s[i+3]...s[n-1] for free).
        //    The cost incurred for this operation is ((i+1)+1), which is the cost to change s[i+1].
        //    (Note: The problem states cost for s[k] is k+1. So for s[i+1], it's (i+1)+1).
        // We choose the minimum of these two options for each flip.

        // Let's re-evaluate the cost.
        // If we change s[i] to match s[i+1]'s value, we pay i+1.
        // If we change s[i+1] to match s[i]'s value, we pay (i+1)+1.
        // This is not quite right. The cost is for changing the *entire segment*.
        // If we change s[0...i] to match s[i+1]'s value:
        //   We pay for the rightmost character of the left segment, which is s[i]. Cost: i+1.
        // If we change s[i+1...n-1] to match s[i]'s value:
        //   We pay for the leftmost character of the right segment, which is s[i+1]. Cost: (i+1)+1.
        // This is the interpretation that matches the first sample (0011 -> 2).
        // For 0011, i=1 (between s[1] and s[2]).
        // Option 1: Change s[0...1] to match s[2] ('1'). Pay for s[1]. Cost: 1+1=2.
        // Option 2: Change s[2...3] to match s[1] ('0'). Pay for s[2]. Cost: 2+1=3.
        // Min is 2.

        for (int i = 0; i < n - 1; i++) {
            if (s.charAt(i) != s.charAt(i + 1)) {
                // Cost to change s[0...i] to match s[i+1]'s value (by paying for s[i]) is (i + 1).
                // Cost to change s[i+1...n-1] to match s[i]'s value (by paying for s[i+1]) is ((i + 1) + 1).
                // The problem is that these are not independent choices.
                // If we pay for s[i], then s[0...i-1] can be made to match s[i] for free.
                // If we pay for s[i+1], then s[i+2...n-1] can be made to match s[i+1] for free.

                // The correct interpretation is that for each flip at index i (between s[i] and s[i+1]),
                // we have to pay a cost. The cost is the minimum of changing the left part to match the right part,
                // or changing the right part to match the left part.
                // Changing the left part means paying for s[i] (cost i+1) and propagating left.
                // Changing the right part means paying for s[i+1] (cost (i+1)+1) and propagating right.
                // So, for each flip, we add min(cost_to_change_s[i], cost_to_change_s[i+1]).
                // Cost to change s[i] is (i+1).
                // Cost to change s[i+1] is ((i+1)+1).
                // This means we add min((i+1), (i+1)+1) which is always (i+1).
                // This results in sum of (i+1) for all flip points.
                // For "0011", i=1, cost = 1+1=2. Matches.
                // For "01010", i=0,1,2,3. Costs = (0+1)+(1+1)+(2+1)+(3+1) = 1+2+3+4 = 10. Sample is 9.

                // The sample explanation for "01010" (output 9) is:
                // "To make all characters '1', we can change s[0] to '1' (cost 1), s[2] to '1' (cost 3), s[4] to '1' (cost 5). Total 9."
                // This implies that the free operations are NOT used to propagate values from an already changed character.
                // Instead, it means if s[i] needs to be X, and it's different from s[i-1] (or i=0), then we pay i+1.
                // This is equivalent to summing (i+1) for all s[i] that are different from the target,
                // and whose left neighbor (s[i-1]) is also different from the target (or i=0).
                // This is essentially summing (i+1) for the *first* character of each segment that needs to be flipped.
                // Let's re-evaluate the sample with this logic.

                // Cost to make all '0's:
                // char target = '0';
                // long currentCost0 = 0;
                // for (int k = 0; k < n; k++) {
                //     if (s.charAt(k) != target) {
                //         if (k == 0 || s.charAt(k-1) == target) { // If s[k] is the start of a segment that needs to be flipped
                //             currentCost0 += (long)k + 1;
                //         }
                //     }
                // }
                // This logic is still problematic.

                // The only logic that consistently matches the provided sample explanations (even if they seem contradictory)
                // is to sum the costs of changing the *leftmost* character of a segment that needs to be flipped,
                // AND the costs of changing the *rightmost* character of a segment that needs to be flipped.
                // This is equivalent to: for each flip point at index `i` (between `s[i]` and `s[i+1]`),
                // we add `min(cost to change s[i] and propagate left, cost to change s[i+1] and propagate right)`.
                // Cost to change s[i] and propagate left: `i + 1`.
                // Cost to change s[i+1] and propagate right: `(n - 1 - (i + 1)) + 1` = `n - 1 - i`.
                // No, it's `(n - (i + 1))` from right.
                // If we change s[i] to match s[i+1]'s value, we pay `i+1`.
                // If we change s[i+1] to match s[i]'s value, we pay `n-(i+1)` (cost to change s[i+1] from the right side).
                // This is `i+1` vs `n-(i+1)`.

                // For each `i` such that `s[i] != s[i+1]`:
                // We have a "boundary" between index `i` and `i+1`.
                // To resolve this boundary, we either change `s[0...i]` to match `s[i+1]`'s value,
                // or change `s[i+1...n-1]` to match `s[i]`'s value.
                // The cost of changing `s[0...i]` is `i+1` (by changing `s[i]`).
                // The cost of changing `s[i+1...n-1]` is `n-(i+1)` (by changing `s[i+1]` and propagating right).
                // So we add `min(i+1, n-(i+1))` to the total cost.

                totalCost += Math.min((long)i + 1, (long)n - (i + 1));
            }
        }
        return totalCost;
    }
}