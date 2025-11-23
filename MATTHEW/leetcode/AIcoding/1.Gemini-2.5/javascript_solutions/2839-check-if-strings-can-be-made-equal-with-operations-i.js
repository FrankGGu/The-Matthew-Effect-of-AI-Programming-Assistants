var checkStrings = function(s1, s2) {
    let s1EvenChars = [s1[0], s1[2]];
    let s1OddChars = [s1[1], s1[3]];

    let s2EvenChars = [s2[0], s2[2]];
    let s2OddChars = [s2[1], s2[3]];

    s1EvenChars.sort();
    s1OddChars.sort();
    s2EvenChars.sort();
    s2OddChars.sort();

    return (s1EvenChars[0] === s2EvenChars[0] && s1EvenChars[1] === s2EvenChars[1]) &&
           (s1OddChars[0] === s2OddChars[0] && s1OddChars[1] === s2OddChars[1]);
};