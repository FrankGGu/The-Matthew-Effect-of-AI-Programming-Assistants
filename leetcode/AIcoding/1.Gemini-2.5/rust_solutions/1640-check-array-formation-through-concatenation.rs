use std::collections::HashMap;

impl Solution {
    pub fn can_form_array(arr: Vec<i32>, pieces: Vec<Vec<i32>>) -> bool {
        let mut piece_map: HashMap<i32, &Vec<i32>> = HashMap::new();
        for piece in &pieces {
            // According to constraints, each piece has at least one element.
            // The first element of each piece is unique among all first elements of pieces
            // if we consider the "all integers in arr and pieces are unique" constraint
            // and the fact that if a piece starts with X, then arr[i] must be X.
            piece_map.insert(piece[0], piece);
        }

        let mut i = 0;
        while i < arr.len() {
            let current_val = arr[i];
            match piece_map.get(&current_val) {
                Some(piece) => {
                    // Check if the current segment of `arr` matches the found `piece`.
                    // First, ensure `piece` can fit into the remaining part of `arr`.
                    if i + piece.len() > arr.len() {
                        return false;
                    }

                    // Compare elements of `piece` with the corresponding segment in `arr`.
                    for j in 0..piece.len() {
                        if arr[i + j] != piece[j] {
                            return false; // Mismatch found
                        }
                    }

                    // If the piece matches, advance the index `i` by the length of the piece.
                    i += piece.len();
                }
                None => {
                    // No piece starts with the current element `arr[i]`,
                    // so `arr` cannot be formed.
                    return false;
                }
            }
        }

        // If we have successfully iterated through the entire `arr`, it means
        // `arr` can be formed by concatenating the pieces.
        true
    }
}