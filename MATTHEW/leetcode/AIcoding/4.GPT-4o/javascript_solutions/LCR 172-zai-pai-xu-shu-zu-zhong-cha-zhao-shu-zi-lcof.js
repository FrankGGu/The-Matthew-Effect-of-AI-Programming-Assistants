var countOccurrences = function(scores, target) {
    return scores.filter(score => score === target).length;
};