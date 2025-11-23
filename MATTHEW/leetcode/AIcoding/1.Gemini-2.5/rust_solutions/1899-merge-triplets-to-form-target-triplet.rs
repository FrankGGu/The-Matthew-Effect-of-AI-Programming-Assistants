impl Solution {
    pub fn merge_triplets(triplets: Vec<Vec<i32>>, target: Vec<i32>) -> bool {
        let mut found_x = false;
        let mut found_y = false;
        let mut found_z = false;

        for triplet in triplets {
            let a = triplet[0];
            let b = triplet[1];
            let c = triplet[2];

            if a <= target[0] && b <= target[1] && c <= target[2] {
                if a == target[0] {
                    found_x = true;
                }
                if b == target[1] {
                    found_y = true;
                }
                if c == target[2] {
                    found_z = true;
                }
            }
        }

        found_x && found_y && found_z
    }
}