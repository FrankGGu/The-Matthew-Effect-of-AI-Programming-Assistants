type AuthenticationManager struct {
    tokens map[string]int
    timeToLive int
}

func Constructor(timeToLive int) AuthenticationManager {
    return AuthenticationManager{
        tokens: make(map[string]int),
        timeToLive: timeToLive,
    }
}

func (this *AuthenticationManager) Generate(tokenId string, currentTime int) {
    this.tokens[tokenId] = currentTime + this.timeToLive
}

func (this *AuthenticationManager) Renew(tokenId string, currentTime int) {
    if expiry, exists := this.tokens[tokenId]; exists && currentTime < expiry {
        this.tokens[tokenId] = currentTime + this.timeToLive
    }
}

func (this *AuthenticationManager) CountUnexpiredTokens(currentTime int) int {
    count := 0
    for _, expiry := range this.tokens {
        if currentTime < expiry {
            count++
        }
    }
    return count
}