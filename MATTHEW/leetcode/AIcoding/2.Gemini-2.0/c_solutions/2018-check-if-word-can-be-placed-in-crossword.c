#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool placeWordHorizontally(char** board, int boardSize, int* boardColSize, int row, int col, char* word) {
    int wordLen = strlen(word);
    if (col + wordLen > *boardColSize) {
        return false;
    }
    if (col > 0 && board[row][col - 1] != '#') {
        return false;
    }
    if (col + wordLen < *boardColSize && board[row][col + wordLen] != '#') {
        return false;
    }
    for (int i = 0; i < wordLen; i++) {
        if (board[row][col + i] != ' ' && board[row][col + i] != word[i]) {
            return false;
        }
    }
    return true;
}

bool placeWordVertically(char** board, int boardSize, int* boardColSize, int row, int col, char* word) {
    int wordLen = strlen(word);
    if (row + wordLen > boardSize) {
        return false;
    }
    if (row > 0 && board[row - 1][col] != '#') {
        return false;
    }
    if (row + wordLen < boardSize && board[row + wordLen][col] != '#') {
        return false;
    }
    for (int i = 0; i < wordLen; i++) {
        if (board[row + i][col] != ' ' && board[row + i][col] != word[i]) {
            return false;
        }
    }
    return true;
}

bool placeWordInCrossword(char** board, int boardSize, int* boardColSize, char* word) {
    int wordLen = strlen(word);
    for (int i = 0; i < boardSize; i++) {
        for (int j = 0; j < *boardColSize; j++) {
            if (board[i][j] == ' ' || board[i][j] == word[0]) {
                if (placeWordHorizontally(board, boardSize, boardColSize, i, j, word)) {
                    return true;
                }
                if (placeWordVertically(board, boardSize, boardColSize, i, j, word)) {
                    return true;
                }
            }
        }
    }
    return false;
}