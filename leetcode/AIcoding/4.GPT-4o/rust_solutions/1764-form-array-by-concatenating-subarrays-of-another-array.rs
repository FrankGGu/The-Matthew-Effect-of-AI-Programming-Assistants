pub fn can_form_array(arr: Vec<i32>, pieces: Vec<Vec<i32>>) -> bool {
    let mut index_map = std::collections::HashMap::new();
    for (i, piece) in pieces.iter().enumerate() {
        index_map.insert(piece[0], i);
    }

    let mut i = 0;
    while i < arr.len() {
        if let Some(&piece_index) = index_map.get(&arr[i]) {
            for &num in &pieces[piece_index] {
                if i < arr.len() && arr[i] == num {
                    i += 1;
                } else {
                    return false;
                }
            }
        } else {
            return false;
        }
    }

    true
}