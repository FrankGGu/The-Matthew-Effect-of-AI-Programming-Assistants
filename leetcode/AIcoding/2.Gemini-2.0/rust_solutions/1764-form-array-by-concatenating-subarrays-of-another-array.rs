impl Solution {
    pub fn can_form_array(arr: Vec<i32>, pieces: Vec<Vec<i32>>) -> bool {
        let mut i = 0;
        while i < arr.len() {
            let mut found = false;
            for piece in &pieces {
                if piece[0] == arr[i] {
                    let mut j = 0;
                    while j < piece.len() && i + j < arr.len() && piece[j] == arr[i + j] {
                        j += 1;
                    }
                    if j == piece.len() {
                        i += j;
                        found = true;
                        break;
                    }
                }
            }
            if !found {
                return false;
            }
        }
        true
    }
}