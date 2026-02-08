pub fn flipgame(fronts: Vec<i32>, backs: Vec<i32>) -> i32 {
    let mut bad_cards = std::collections::HashSet::new();
    for i in 0..fronts.len() {
        if fronts[i] == backs[i] {
            bad_cards.insert(fronts[i]);
        }
    }
    let mut result = i32::MAX;
    for &f in &fronts {
        if !bad_cards.contains(&f) {
            result = result.min(f);
        }
    }
    for &b in &backs {
        if !bad_cards.contains(&b) {
            result = result.min(b);
        }
    }
    if result == i32::MAX { 0 } else { result }
}