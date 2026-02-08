int game(int* guess, int guessSize, int* answer, int answerSize){
    int correct_guesses = 0;
    for (int i = 0; i < 3; i++) {
        if (guess[i] == answer[i]) {
            correct_guesses++;
        }
    }
    return correct_guesses;
}