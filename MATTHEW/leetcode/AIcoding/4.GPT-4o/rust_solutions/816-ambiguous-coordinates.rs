impl Solution {
    pub fn ambiguous_coordinates(s: String) -> Vec<String> {
        let s = &s[1..s.len() - 1];
        let n = s.len();
        let mut result = Vec::new();

        for i in 1..n {
            let left = &s[0..i];
            let right = &s[i..n];

            let left_coords = Self::generate_coords(left);
            let right_coords = Self::generate_coords(right);

            for l in left_coords {
                for r in right_coords {
                    result.push(format!("({}, {})", l, r));
                }
            }
        }

        result
    }

    fn generate_coords(part: &str) -> Vec<String> {
        let mut coords = Vec::new();
        let len = part.len();

        if len == 1 {
            coords.push(part.to_string());
        } else {
            if part.starts_with('0') && part.ends_with('0') {
                return coords;
            }
            if part.starts_with('0') {
                coords.push(format!("0.{}", &part[1..]));
            } else {
                coords.push(part.to_string());
            }
            if !part.ends_with('0') {
                coords.push(format!("{}.{}}", &part[..len - 1], &part[len - 1..]));
            }
        }

        coords
    }
}