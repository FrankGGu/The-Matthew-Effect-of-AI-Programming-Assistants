var areSentencesSimilar = function(sentence1, sentence2) {
    const words1 = sentence1.split(' ');
    const words2 = sentence2.split(' ');

    if (words1.length > words2.length) {
        return areSentencesSimilar(sentence2, sentence1);
    }

    let i = 0, j = words2.length - 1;

    while (i < words1.length && words1[i] === words2[i]) {
        i++;
    }

    while (j >= 0 && words1[words1.length - 1 - (words2.length - 1 - j)] === words2[j]) {
        j--;
    }

    return i + (words2.length - 1 - j) === words1.length;
};