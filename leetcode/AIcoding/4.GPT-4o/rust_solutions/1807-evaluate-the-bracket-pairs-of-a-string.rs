pub fn evaluate(s: String, knowledge: Vec<Vec<String>>) -> String {
    use std::collections::HashMap;

    let mut map = HashMap::new();
    for kv in knowledge {
        map.insert(kv[0].clone(), kv[1].clone());
    }

    let mut result = String::new();
    let mut i = 0;

    while i < s.len() {
        if let Some(start) = s[i..].find('(') {
            result.push_str(&s[i..i + start]);
            let end = s[i + start..].find(')').unwrap() + i + start;
            let key = &s[i + start + 1..end];
            if let Some(value) = map.get(key) {
                result.push_str(value);
            } else {
                result.push('?');
            }
            i = end + 1;
        } else {
            result.push_str(&s[i..]);
            break;
        }
    }

    result
}