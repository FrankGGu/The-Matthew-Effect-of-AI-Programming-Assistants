impl Solution {
    pub fn can_form_array(arr: Vec<i32>, pieces: Vec<Vec<i32>>) -> bool {
        let mut pos = vec![0; 101];
        for (i, piece) in pieces.iter().enumerate() {
            pos[piece[0] as usize] = i + 1;
        }

        let mut i = 0;
        while i < arr.len() {
            if let Some(&piece_index) = pos.get(arr[i] as usize) {
                if piece_index == 0 {
                    return false;
                }
                let piece = &pieces[piece_index - 1];
                if arr[i..i + piece.len()] != *piece {
                    return false;
                }
                i += piece.len();
            } else {
                return false;
            }
        }
        true
    }
}