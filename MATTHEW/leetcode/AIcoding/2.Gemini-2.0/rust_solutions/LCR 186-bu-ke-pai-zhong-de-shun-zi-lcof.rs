impl Solution {
    pub fn is_dynasty(dates: Vec<String>) -> Vec<String> {
        let mut result: Vec<String> = Vec::new();
        for date in dates {
            let parts: Vec<&str> = date.split(' ').collect();
            if parts.len() != 3 {
                result.push("Unknown".to_string());
                continue;
            }

            let dynasty = parts[0];
            let period = parts[1];
            let year = parts[2].parse::<i32>();

            if year.is_err() {
                result.push("Unknown".to_string());
                continue;
            }

            let year = year.unwrap();

            match dynasty {
                "Xia" => {
                    if year >= -2070 && year <= -1600 {
                        result.push(dynasty.to_string());
                    } else {
                        result.push("Unknown".to_string());
                    }
                }
                "Shang" => {
                    if year >= -1600 && year <= -1046 {
                        result.push(dynasty.to_string());
                    } else {
                        result.push("Unknown".to_string());
                    }
                }
                "Zhou" => {
                    if year >= -1046 && year <= -256 {
                        result.push(dynasty.to_string());
                    } else {
                        result.push("Unknown".to_string());
                    }
                }
                "Qin" => {
                    if year >= -221 && year <= -206 {
                        result.push(dynasty.to_string());
                    } else {
                        result.push("Unknown".to_string());
                    }
                }
                "Han" => {
                    if year >= -206 && year <= 220 {
                        result.push(dynasty.to_string());
                    } else {
                        result.push("Unknown".to_string());
                    }
                }
                "Sui" => {
                    if year >= 581 && year <= 618 {
                        result.push(dynasty.to_string());
                    } else {
                        result.push("Unknown".to_string());
                    }
                }
                "Tang" => {
                    if year >= 618 && year <= 907 {
                        result.push(dynasty.to_string());
                    } else {
                        result.push("Unknown".to_string());
                    }
                }
                "Song" => {
                    if year >= 960 && year <= 1279 {
                        result.push(dynasty.to_string());
                    } else {
                        result.push("Unknown".to_string());
                    }
                }
                "Yuan" => {
                    if year >= 1271 && year <= 1368 {
                        result.push(dynasty.to_string());
                    } else {
                        result.push("Unknown".to_string());
                    }
                }
                "Ming" => {
                    if year >= 1368 && year <= 1644 {
                        result.push(dynasty.to_string());
                    } else {
                        result.push("Unknown".to_string());
                    }
                }
                "Qing" => {
                    if year >= 1644 && year <= 1912 {
                        result.push(dynasty.to_string());
                    } else {
                        result.push("Unknown".to_string());
                    }
                }
                _ => {
                    result.push("Unknown".to_string());
                }
            }
        }
        result
    }
}