var areSentencesSimilar = function(sentence1, sentence2) {
    const words1 = sentence1.split(' ');
    const words2 = sentence2.split(' ');

    let i = 0;
    let j = 0;

    while (i < words1.length && j < words2.length && words1[i] === words2[j]) {
        i++;
        j++;
    }

    let k = words1.length - 1;
    let l = words2.length - 1;

    while (k >= i && l >= j && words1[k] === words2[l]) {
        k--;
        l--;
    }

    return i > k || j > l;
};