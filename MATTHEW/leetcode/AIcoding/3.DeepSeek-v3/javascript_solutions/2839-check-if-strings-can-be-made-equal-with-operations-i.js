var canBeEqual = function(s1, s2) {
    if (s1 === s2) return true;
    let swapped = s1[0] + s1[3] + s1[2] + s1[1];
    if (swapped === s2) return true;
    swapped = s1[2] + s1[1] + s1[0] + s1[3];
    if (swapped === s2) return true;
    swapped = s1[2] + s1[3] + s1[0] + s1[1];
    if (swapped === s2) return true;
    return false;
};