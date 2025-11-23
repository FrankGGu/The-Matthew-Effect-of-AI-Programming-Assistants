var isIsomorphic = function(s, t) {
    const mapS = new Map();
    const mapT = new Map();

    for (let i = 0; i < s.length; i++) {
        const charS = s[i];
        const charT = t[i];

        if (!mapS.has(charS)) {
            mapS.set(charS, charT);
        }
        if (!mapT.has(charT)) {
            mapT.set(charT, charS);
        }

        if (mapS.get(charS) !== charT || mapT.get(charT) !== charS) {
            return false;
        }
    }
    return true;
};