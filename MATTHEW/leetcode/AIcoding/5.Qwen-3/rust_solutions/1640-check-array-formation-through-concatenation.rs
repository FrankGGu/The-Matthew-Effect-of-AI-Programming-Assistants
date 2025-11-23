pub fn can_form_array(boxes: Vec<Vec<i32>>, arr: Vec<i32>) -> bool {
    use std::collections::HashMap;

    let mut map = HashMap::new();
    for (i, box_) in boxes.iter().enumerate() {
        map.insert(box_[0], i);
    }

    let mut i = 0;
    while i < arr.len() {
        if let Some(&index) = map.get(&arr[i]) {
            let box_ = &boxes[index];
            let len = box_.len();
            if i + len > arr.len() {
                return false;
            }
            for j in 0..len {
                if arr[i + j] != box_[j] {
                    return false;
                }
            }
            i += len;
        } else {
            return false;
        }
    }
    true
}