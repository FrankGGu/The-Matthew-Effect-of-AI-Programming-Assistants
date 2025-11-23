function truncateSentence(sentence, k) {
    return sentence.split(" ").slice(0, k).join(" ");
}