pub fn split_message(message: String, limit: usize) -> Vec<String> {
    let mut result = Vec::new();
    let mut current_length = 0;
    let mut part_number = 1;

    for part in 1..=10000 {
        let part_suffix = format("/{}/{}", part, part_number);
        let part_length = part_suffix.len();
        let available_length = limit.saturating_sub(part_length);

        if current_length + message.len() <= available_length {
            result.push(format!("{}{}", &message[current_length..], part_suffix));
            current_length += message.len();
        } else {
            let remaining_length = available_length - current_length;
            if remaining_length > 0 {
                result.push(format!("{}{}", &message[..remaining_length], part_suffix));
            }
            break;
        }

        part_number += 1;
    }

    result
}