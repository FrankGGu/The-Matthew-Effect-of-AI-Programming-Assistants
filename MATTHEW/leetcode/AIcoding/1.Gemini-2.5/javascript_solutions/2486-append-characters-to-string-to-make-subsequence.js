var appendCharacters = function(s, t) {
    let s_ptr = 0;
    let t_ptr = 0;

    while (s_ptr < s.length && t_ptr < t.length) {
        if (s[s_ptr] === t[t_ptr]) {
            s_ptr++;
        }
        t_ptr++;
    }

    return s.length - s_ptr;
};