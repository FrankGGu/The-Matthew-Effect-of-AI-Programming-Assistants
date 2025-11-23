impl Solution {
    pub fn disassemble_attack(attack: String) -> Vec<String> {
        let mut result = Vec::new();
        for i in 0..attack.len() {
            for j in i + 1..=attack.len() {
                result.push(attack[i..j].to_string());
            }
        }
        result
    }
}