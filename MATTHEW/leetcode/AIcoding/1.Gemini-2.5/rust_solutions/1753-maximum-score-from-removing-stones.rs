impl Solution {
    pub fn maximum_score(a: i32, b: i32, c: i32) -> i32 {
        let mut piles = vec![a, b, c];
        piles.sort_unstable(); // Sorts in ascending order
        let x = piles[0]; // Smallest pile
        let y = piles[1]; // Middle pile
        let z = piles[2]; // Largest pile

        // Case 1: The largest pile (z) is too large compared to the sum of the other two (x + y).
        // In this scenario, we can always pair stones from x and y with stones from z.
        // We will deplete x and y completely, and z will still have stones left.
        // The number of operations is limited by the total number of stones in x and y.
        // Each operation removes one stone from x (or y) and one from z.
        // So, we can perform x + y operations.
        if z >= x + y {
            x + y
        } 
        // Case 2: The largest pile (z) is not too large.
        // This means z < x + y. In this situation, the piles are relatively balanced.
        // We can always find two non-empty piles to remove stones from until at most one pile remains.
        // Each operation removes 2 stones from the total sum (x + y + z).
        // The maximum number of operations is thus half of the total sum, rounded down (integer division).
        else {
            (x + y + z) / 2
        }
    }
}