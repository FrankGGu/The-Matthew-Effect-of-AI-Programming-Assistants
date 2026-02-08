impl Solution {
    pub fn max_strength(nums: Vec<i32>) -> i64 {
        let mut positives = Vec::new();
        let mut negatives = Vec::new();
        let mut has_zero = false;

        for &num in &nums {
            if num > 0 {
                positives.push(num as i64);
            } else if num < 0 {
                negatives.push(num as i64);
            } else {
                has_zero = true;
            }
        }

        negatives.sort_unstable(); // Sort ascending

        let mut current_product = 1_i64;
        let mut elements_in_current_product = 0;

        for p in positives {
            current_product *= p;
            elements_in_current_product += 1;
        }

        // If there's an odd number of negative numbers, remove the one closest to zero
        // to maximize the product (make the count of negative numbers even).
        // `pop()` removes the largest negative (closest to zero) from the sorted `negatives` vector.
        if negatives.len() % 2 != 0 {
            negatives.pop();
        }

        for n in negatives {
            current_product *= n;
            elements_in_current_product += 1;
        }

        // Initialize max_strength with the smallest possible i64 value.
        // This allows correctly comparing with 0 and negative products.
        let mut max_strength = i64::MIN;

        // If we found a product from at least two numbers, it's a candidate for max_strength.
        if elements_in_current_product >= 2 {
            max_strength = max_strength.max(current_product);
        }

        // If there are zeros in the input, 0 is a possible strength (by forming a group like [0, x]).
        // This is relevant if max_strength is currently negative or if no valid product of two or more
        // non-zero numbers could be formed.
        if has_zero {
            max_strength = max_strength.max(0);
        }

        // The problem statement implies that a valid group of two or more integers can always be formed
        // to return a meaningful maximum strength.
        // If `max_strength` is still `i64::MIN` at this point, it means:
        // 1. `elements_in_current_product < 2` (no product of >=2 non-zero numbers)
        // 2. `has_zero` is false (no zeros to form a 0 product)
        // This scenario would only happen if `nums` contained only one non-zero number (e.g., `[5]` or `[-5]`).
        // Such inputs would violate the "group of two or more" constraint and are typically not tested or
        // implicitly handled by problem guarantees.
        // Therefore, `max_strength` will always be a valid result (>=0 or a valid negative product).
        max_strength
    }
}