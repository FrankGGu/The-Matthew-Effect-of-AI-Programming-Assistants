impl Solution {
    pub fn is_long_pressed_name(name: String, typed: String) -> bool {
        let mut i = 0;
        let mut j = 0;
        let name_bytes = name.as_bytes();
        let typed_bytes = typed.as_bytes();

        while j < typed.len() {
            if i < name.len() && name_bytes[i] == typed_bytes[j] {
                i += 1;
            } else if j == 0 || typed_bytes[j] != typed_bytes[j - 1] {
                return false;
            }
            j += 1;
        }
        i == name.len()
    }
}