pub fn merge_triplets(triplets: Vec<Vec<i32>>, target: Vec<i32>) -> bool {
    let mut can_form = vec![false; 3];

    for triplet in triplets {
        if triplet[0] > target[0] || triplet[1] > target[1] || triplet[2] > target[2] {
            continue;
        }
        for i in 0..3 {
            if triplet[i] == target[i] {
                can_form[i] = true;
            }
        }
    }

    can_form.iter().enumerate().all(|(i, &v)| v || target[i] == 0)
}