var longestNiceSubstring = function(s) {
    if (s.length < 2) return "";

    let set = new Set(s);

    for (let i = 0; i < s.length; i++) {
        let char = s[i];
        if (set.has(char.toUpperCase()) && set.has(char.toLowerCase())) continue;

        let s1 = longestNiceSubstring(s.substring(0, i));
        let s2 = longestNiceSubstring(s.substring(i + 1));

        return s1.length >= s2.length ? s1 : s2;
    }

    return s;
};