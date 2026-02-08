package main

func squareIsWhite(s string) bool {
    return (s[0]-'a' + s[1]-'1') % 2 == 1
}