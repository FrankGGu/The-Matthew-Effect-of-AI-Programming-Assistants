var maxDiff = function(num) {
    const s = String(num);
    let max_val_str = '';
    let min_val_str = '';

    // Calculate max_val
    let char_to_replace_for_max = '';
    for (let i = 0; i < s.length; i++) {
        if (s[i] !== '9') {
            char_to_replace_for_max = s[i];
            break;
        }
    }
    if (char_to_replace_for_max === '') {
        max_val_str = s;
    } else {
        max_val_str = s.replaceAll(char_to_replace_for_max, '9');
    }
    const max_val = parseInt(max_val_str);

    // Calculate min_val
    let char_to_replace_for_min = '';
    const first_char = s[0];

    if (first_char === '1') {
        for (let i = 1; i < s.length; i++) {
            if (s[i] !== '0' && s[i] !== '1') {
                char_to_replace_for_min = s[i];
                break;
            }
        }
        if (char_to_replace_for_min === '') {
            min_val_str = s.replaceAll('1', '0');
        } else {
            min_val_str = s.replaceAll(char_to_replace_for_min, '0');
        }
    } else {
        char_to_replace_for_min = first_char;
        min_val_str = s.replaceAll(char_to_replace_for_min, '1');
    }
    const min_val = parseInt(min_val_str);

    return max_val - min_val;
};