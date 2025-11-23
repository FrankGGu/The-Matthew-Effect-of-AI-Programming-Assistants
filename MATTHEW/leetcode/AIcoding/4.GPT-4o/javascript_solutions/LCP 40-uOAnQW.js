function canPassChallenge(correct, incorrect) {
    return correct >= 10 && (correct - incorrect) >= 2;
}