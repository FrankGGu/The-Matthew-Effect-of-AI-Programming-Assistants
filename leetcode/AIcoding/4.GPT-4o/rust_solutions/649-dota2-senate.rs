pub fn predict_party_victory(senate: String) -> String {
    let mut radiant = 0;
    let mut dire = 0;
    let mut queue: Vec<char> = Vec::new();

    for c in senate.chars() {
        if c == 'R' {
            radiant += 1;
        } else {
            dire += 1;
        }
        queue.push(c);
    }

    while radiant > 0 && dire > 0 {
        let c = queue.remove(0);
        if c == 'R' {
            dire -= 1;
            if dire >= 0 {
                queue.push('R');
            }
        } else {
            radiant -= 1;
            if radiant >= 0 {
                queue.push('D');
            }
        }
    }

    if radiant > 0 {
        "Radiant".to_string()
    } else {
        "Dire".to_string()
    }
}