impl Solution {
    pub fn merge_triplets(triplets: Vec<Vec<i32>>, target: Vec<i32>) -> bool {
        let mut good1 = false;
        let mut good2 = false;
        let mut good3 = false;

        for triplet in triplets {
            if triplet[0] <= target[0] && triplet[1] <= target[1] && triplet[2] <= target[2] {
                if triplet[0] == target[0] && triplet[1] <= target[1] && triplet[2] <= target[2] {
                    good1 = true;
                }
                if triplet[0] <= target[0] && triplet[1] == target[1] && triplet[2] <= target[2] {
                    good2 = true;
                }
                if triplet[0] <= target[0] && triplet[1] <= target[1] && triplet[2] == target[2] {
                    good3 = true;
                }
            }
        }

        good1 && good2 && good3
    }
}