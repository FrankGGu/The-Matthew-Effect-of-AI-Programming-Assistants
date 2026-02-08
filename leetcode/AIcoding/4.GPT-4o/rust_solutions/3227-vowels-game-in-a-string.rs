impl Solution {
    pub fn vowels_game(s: String) -> String {
        let vowels = "aeiouAEIOU";
        let mut alice_score = 0;
        let mut bob_score = 0;

        for (i, c) in s.chars().enumerate() {
            if vowels.contains(c) {
                if i % 2 == 0 {
                    alice_score += 1;
                } else {
                    bob_score += 1;
                }
            }
        }

        if alice_score > bob_score {
            "Alice".to_string()
        } else if bob_score > alice_score {
            "Bob".to_string()
        } else {
            "Draw".to_string()
        }
    }
}