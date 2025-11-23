var isIsomorphic = function(s, t) {
    if (s.length !== t.length) return false;

    const sToT = {};
    const tToS = {};

    for (let i = 0; i < s.length; i++) {
        const charS = s[i];
        const charT = t[i];

        if (sToT[charS] === undefined && tToS[charT] === undefined) {
            sToT[charS] = charT;
            tToS[charT] = charS;
        } else {
            if (sToT[charS] !== charT || tToS[charT] !== charS) {
                return false;
            }
        }
    }

    return true;
};