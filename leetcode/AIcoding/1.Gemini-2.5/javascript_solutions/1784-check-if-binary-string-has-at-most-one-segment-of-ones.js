var checkOnesSegment = function(s) {
    const segmentsOfOnes = s.split('0').filter(segment => segment.length > 0);
    return segmentsOfOnes.length <= 1;
};