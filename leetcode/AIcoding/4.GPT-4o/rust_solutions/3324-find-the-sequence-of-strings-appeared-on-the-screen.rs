pub fn can_form_array(arr: Vec<i32>, pieces: Vec<Vec<i32>>) -> bool {
    let mut pos = vec![0; 101];
    for (i, piece) in pieces.iter().enumerate() {
        pos[piece[0] as usize] = i + 1;
    }

    let mut i = 0;
    while i < arr.len() {
        if pos[arr[i] as usize] == 0 {
            return false;
        }
        let idx = pos[arr[i] as usize] - 1;
        for &x in &pieces[idx] {
            if i >= arr.len() || arr[i] != x {
                return false;
            }
            i += 1;
        }
    }
    true
}