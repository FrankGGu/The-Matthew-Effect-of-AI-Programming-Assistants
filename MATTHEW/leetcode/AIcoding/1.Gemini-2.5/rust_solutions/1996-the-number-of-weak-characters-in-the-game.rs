impl Solution {
    pub fn number_of_weak_characters(mut properties: Vec<Vec<i32>>) -> i32 {
        // Sort the characters based on the following criteria:
        // 1. Primary sort key: attack in descending order.
        // 2. Secondary sort key (for ties in attack): defense in ascending order.
        // This sorting strategy is crucial for the single-pass approach.
        properties.sort_unstable_by(|a, b| {
            if a[0] != b[0] {
                // Sort by attack in descending order
                b[0].cmp(&a[0])
            } else {
                // For ties in attack, sort by defense in ascending order
                a[1].cmp(&b[1])
            }
        });

        let mut weak_characters = 0;
        let mut max_defense_so_far = 0; // Tracks the maximum defense encountered from characters processed so far.

        // Iterate through the sorted characters.
        // Due to the sorting:
        // - When processing a character [attack_i, defense_i], all previously processed characters
        //   [attack_j, defense_j] have attack_j >= attack_i.
        // - If attack_j > attack_i, then max_defense_so_far correctly holds the maximum defense
        //   among characters with strictly greater attack.
        // - If attack_j == attack_i, then due to the secondary sort, defense_j <= defense_i.
        //   In this case, defense_j cannot be strictly greater than defense_i, so such a character
        //   cannot make [attack_i, defense_i] weak.
        for character in properties {
            let defense = character[1];
            if defense < max_defense_so_far {
                // If the current character's defense is less than the maximum defense
                // encountered from characters with greater or equal attack, it means
                // there exists a character [attack_j, defense_j] such that:
                // 1. attack_j > attack_i (guaranteed by max_defense_so_far being updated only by
                //    characters with attack_j >= attack_i, and the current character having attack_i)
                // 2. defense_j > defense_i (guaranteed by defense < max_defense_so_far)
                // Thus, the current character is weak.
                weak_characters += 1;
            } else {
                // This character is not weak based on previously processed characters.
                // It might become the new maximum defense for subsequent characters.
                max_defense_so_far = defense;
            }
        }

        weak_characters
    }
}