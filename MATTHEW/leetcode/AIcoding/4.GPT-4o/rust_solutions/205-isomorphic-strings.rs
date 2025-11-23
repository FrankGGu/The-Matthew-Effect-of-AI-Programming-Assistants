impl Solution {
    pub fn is_isomorphic(s: String, t: String) -> bool {
        let mut map_s_to_t = std::collections::HashMap::new();
        let mut map_t_to_s = std::collections::HashMap::new();

        for (char_s, char_t) in s.chars().zip(t.chars()) {
            if map_s_to_t.insert(char_s, char_t) != map_t_to_s.insert(char_t, char_s) {
                return false;
            }
        }
        true
    }
}