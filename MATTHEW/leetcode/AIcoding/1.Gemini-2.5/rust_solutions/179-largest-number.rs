use std::cmp::Ordering;

impl Solution {
    pub fn largest_number(nums: Vec<i32>) -> String {
        let mut s_nums: Vec<String> = nums.into_iter().map(|n| n.to_string()).collect();

        s_nums.sort_by(|a, b| {
            // Custom comparison logic:
            // To determine the order of two numbers 'a' and 'b',
            // we compare the string formed by concatenating 'a' then 'b' (ab)
            // with the string formed by concatenating 'b' then 'a' (ba).
            // If 'ba' is lexicographically greater than 'ab', it means 'b' should come before 'a'
            // in the final largest number.
            // We want to sort in descending order based on this custom comparison.
            // So, if (b + a) > (a + b), 'b' is considered "larger" than 'a',
            // and `sort_by` should place 'b' before 'a' (return Ordering::Greater).
            let order1 = format!("{}{}", a, b);
            let order2 = format!("{}{}", b, a);
            order2.cmp(&order1)
        });

        // Handle the edge case where all numbers are zero (e.g., [0, 0, 0]).
        // The sorted result would be "000", which should be "0".
        // If the first element after sorting is "0", it implies all elements were "0"
        // (or the list was empty, which is handled by map_or).
        if s_nums.get(0).map_or(false, |s| s == "0") {
            return "0".to_string();
        }

        s_nums.join("")
    }
}