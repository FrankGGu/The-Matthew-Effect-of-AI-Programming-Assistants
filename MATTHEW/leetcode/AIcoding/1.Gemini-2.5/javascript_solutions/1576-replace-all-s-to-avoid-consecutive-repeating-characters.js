var replaceQuestionMarks = function(s) {
    const n = s.length;
    const s_arr = s.split('');

    for (let i = 0; i < n; i++) {
        if (s_arr[i] === '?') {
            for (let char_code = 97; char_code <= 99; char_code++) { // Try 'a', 'b', 'c'
                const char_to_try = String.fromCharCode(char_code);

                // Check if char_to_try is different from the left neighbor
                // s_arr[i - 1] will be undefined if i is 0, and undefined !== char_to_try is true.
                const left_ok = (s_arr[i - 1] !== char_to_try);

                // Check if char_to_try is different from the right neighbor
                // s_arr[i + 1] will be undefined if i is n - 1, and undefined !== char_to_try is true.
                const right_ok = (s_arr[i + 1] !== char_to_try);

                if (left_ok && right_ok) {
                    s_arr[i] = char_to_try;
                    break; // Found a valid character, move to the next '?'
                }
            }
        }
    }

    return s_arr.join('');
};