use std::collections::HashSet;

impl Solution {
    pub fn find_valid_serial_numbers(serials: Vec<String>) -> Vec<String> {
        let mut seen: HashSet<String> = HashSet::new();
        let mut valid_serials = Vec::new();

        for serial in serials {
            if seen.insert(serial.clone()) {
                valid_serials.push(serial);
            }
        }

        valid_serials
    }
}